using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Commands.Users.UpdateUserCommand;

public record UpdateUserCommand(int Id, string Firstname, string Lastname, string Email, string PhoneNumber) 
    : IRequest<Unit>;