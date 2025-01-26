using FluentValidation;

namespace Library.Application.Commands.Users.Delete;

public class DeleteUserValidator : AbstractValidator<DeleteUserCommand>
{
    public DeleteUserValidator()
    {
        RuleFor(x => x.Id)
            .NotEmpty()
            .WithMessage($"{nameof(DeleteUserCommand.Id)} cannot be empty");
    }
}