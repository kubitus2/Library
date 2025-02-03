using AutoMapper;
using Library.Contracts.DTOs;
using Library.Contracts.Exceptions;
using Library.Contracts.Responses;
using Library.Domain.Repositories;
using Library.Infrastructure;
using Library.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Queries.Users.GetUserById;

public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, Response<UserDto>>
{
    private readonly IUserRepository _repository;
    private readonly IMapper _mapper;

    public GetUserByIdQueryHandler(IMapper mapper, IUserRepository repository)
    {
        _mapper = mapper;
        _repository = repository;
    }

    public async Task<Response<UserDto>> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
    {
        var user = await _repository.GetById(request.Id, cancellationToken);

        if (user is null)
            return Response<UserDto>.Fail("User not found", 404);

        return Response<UserDto>.Success(_mapper.Map<UserDto>(user));
    }
}