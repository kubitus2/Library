using MediatR;

namespace Library.Application.Commands.Users.CreateUserCommand;

public record CreateUserCommand(string FirstName, string LastName, string PhoneNumber, string Email) : IRequest<int>;
