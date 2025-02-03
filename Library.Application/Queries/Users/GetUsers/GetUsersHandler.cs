using AutoMapper;
using Library.Contracts.DTOs;
using Library.Contracts.Responses;
using Library.Domain.Models;
using Library.Domain.Repositories;
using Library.Infrastructure;
using Library.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Queries.Users;

public class GetUsersHandler : IRequestHandler<GetUsersQuery, Response<ICollection<UserDto>>>
{
    private readonly IUserRepository _repository;
    private readonly IMapper _mapper;

    public GetUsersHandler(IMapper mapper, IUserRepository repository)
    {
        _mapper = mapper;
        _repository = repository;
    }

    public async Task<Response<ICollection<UserDto>>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var users = await _repository.GetAll(cancellationToken);

        var userDtos = users.Select(u => _mapper.Map<UserDto>(u)).ToList();

        return Response<ICollection<UserDto>>.Success(userDtos);
    }
}