using FluentValidation;

namespace Library.Application.Commands.Users.Create;

public class CreateUserValidator : AbstractValidator<CreateUserCommand>
{
    public CreateUserValidator()
    {
        RuleFor(x => x.FirstName)
            .NotEmpty()
            .WithMessage($"{nameof(CreateUserCommand.FirstName)} cannot be empty");
        RuleFor(x => x.LastName)
            .NotEmpty()
            .WithMessage($"{nameof(CreateUserCommand.LastName)} cannot be empty");
        RuleFor(x => x.Phone)
            .NotEmpty()
            .WithMessage($"{nameof(CreateUserCommand.Phone)} cannot be empty");
        RuleFor(x => x.Email)
            .NotEmpty()
            .WithMessage($"{nameof(CreateUserCommand.Email)} cannot be empty")
            .EmailAddress()
            .WithMessage("Invalid email address");
    }
}