using Library.Contracts.Responses;
using MediatR;

namespace Library.Application.Commands.Users.Delete;

public record DeleteUserCommand(int Id) : IRequest<Response>;
