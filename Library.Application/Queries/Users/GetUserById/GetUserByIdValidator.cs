using FluentValidation;

namespace Library.Application.Queries.Users.GetUserById;

public class GetUserByIdValidator : AbstractValidator<GetUserByIdQuery>
{
    public GetUserByIdValidator()
    {
        RuleFor(u => u.Id)
            .NotEmpty()
            .WithMessage($"{nameof(GetUserByIdQuery.Id)} is required.");
    }
}