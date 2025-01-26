using Library.Contracts.DTOs;
using Library.Contracts.Responses;
using MediatR;

namespace Library.Application.Queries.Users.GetUserById;

public record GetUserByIdQuery(int Id) : IRequest<Response<UserDto>>;
