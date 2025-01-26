using FluentValidation;
using Library.Contracts.Errors;
using Library.Contracts.Exceptions;
using MediatR;

namespace Library.Application.Behaviours;

public class ValidationBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidationBehaviour(IEnumerable<IValidator<TRequest>> validators)
    {
        _validators = validators;
    }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        var context = new ValidationContext<TRequest>(request);
        var validationResults = await Task.WhenAll(
            _validators.Select(v => v.ValidateAsync(context, cancellationToken)));

        var failures = validationResults.Where(f => !f.IsValid)
            .SelectMany(x => x.Errors)
            .Select(x => new ValidationError
            {
                Property = x.PropertyName,
                Message = x.ErrorMessage
            }).ToList();

        if (failures.Any())
            throw new CustomValidationException(failures);

        var response = await next();
        return response;
    }
}