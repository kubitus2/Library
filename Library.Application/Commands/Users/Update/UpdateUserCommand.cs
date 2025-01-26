using Library.Contracts.DTOs;
using MediatR;

namespace Library.Application.Commands.Users.Update;

public record UpdateUserCommand(UpdateUserDto dto) : IRequest<Unit>
{
    public int Id { get; set; } = dto.Id;
    public string FirstName { get; set; } = dto.FirstName;
    public string LastName { get; set; } = dto.LastName;
    public string Email { get; set; } = dto.Email;
    public string Phone { get; set; } = dto.Phone;
}