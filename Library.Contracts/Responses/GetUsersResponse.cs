using Library.Contracts.DTOs;

namespace Library.Contracts.Responses;

public record GetUsersResponse(List<UserDto> dtos)
{
}