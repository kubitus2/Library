using AutoMapper;
using Library.Contracts.DTOs;
using Library.Contracts.Responses;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Queries.Users;

public class GetUsersHandler : IRequestHandler<GetUsersQuery, Response<ICollection<UserDto>>>
{
    private readonly LibraryDbContext _context;
    private readonly IMapper _mapper;

    public GetUsersHandler(LibraryDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<Response<ICollection<UserDto>>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var users = await _context.Users
            .Where(u => u.IsActive)
            .ToListAsync(cancellationToken);

        var userDtos = users.Select(u => _mapper.Map<UserDto>(u)).ToList();

        return Response<ICollection<UserDto>>.Success(userDtos);
    }
}