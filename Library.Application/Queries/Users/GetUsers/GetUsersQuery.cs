using Library.Contracts.Responses;
using MediatR;

namespace Library.Application.Queries.Users;

public record GetUsersQuery : IRequest<GetUsersResponse>;
