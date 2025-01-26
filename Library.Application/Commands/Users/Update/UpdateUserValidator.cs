using FluentValidation;

namespace Library.Application.Commands.Users.Update;

public class UpdateUserValidator : AbstractValidator<UpdateUserCommand>
{
    public UpdateUserValidator()
    {
        RuleFor(u => u.Id)
            .NotEmpty()
            .WithMessage($"{nameof(UpdateUserCommand.Id)} is required");
        RuleFor(x => x.FirstName)
            .NotEmpty()
            .WithMessage($"{nameof(UpdateUserCommand.FirstName)} cannot be empty");
        RuleFor(x => x.LastName)
            .NotEmpty()
            .WithMessage($"{nameof(UpdateUserCommand.LastName)} cannot be empty");
        RuleFor(x => x.Phone)
            .NotEmpty()
            .WithMessage($"{nameof(UpdateUserCommand.Phone)} cannot be empty");
        RuleFor(x => x.Email)
            .NotEmpty()
            .WithMessage($"{nameof(UpdateUserCommand.Email)} cannot be empty")
            .EmailAddress()
            .WithMessage("Invalid email address");
    }
}