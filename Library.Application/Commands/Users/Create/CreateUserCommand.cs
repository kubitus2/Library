using Library.Contracts.DTOs;
using MediatR;

namespace Library.Application.Commands.Users.Create;

public record CreateUserCommand(CreateUserDto dto) : IRequest<int>
{
    public string FirstName { get; set; } = dto.FirstName;
    public string LastName { get; set; } = dto.LastName;
    public string Email { get; set; } = dto.Email;
    public string Phone { get; set; } = dto.Phone;
}