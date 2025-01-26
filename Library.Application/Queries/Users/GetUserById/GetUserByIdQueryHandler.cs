using AutoMapper;
using Library.Contracts.DTOs;
using Library.Contracts.Exceptions;
using Library.Contracts.Responses;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Queries.Users.GetUserById;

public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, Response<UserDto>>
{
    private readonly LibraryDbContext _dbContext;
    private readonly IMapper _mapper;

    public GetUserByIdQueryHandler(LibraryDbContext dbContext, IMapper mapper)
    {
        _dbContext = dbContext;
        _mapper = mapper;
    }
    
    public async Task<Response<UserDto>> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
    {
        var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Id == request.Id && u.IsActive, cancellationToken);

        if (user is null)
            return Response<UserDto>.Fail("User not found", 404);

        return  Response<UserDto>.Success(_mapper.Map<UserDto>(user));
    }
}