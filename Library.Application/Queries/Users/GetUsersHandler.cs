using AutoMapper;
using Library.Contracts.Responses;
using Library.Infrastructure;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Library.Application.Queries.Users;

public class GetUsersHandler : IRequestHandler<GetUsersQuery, GetUsersResponse>
{
    private readonly LibraryDbContext _context;
    private readonly IMapper _mapper;

    public GetUsersHandler(LibraryDbContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    public async Task<GetUsersResponse> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var users = await _context.Users.ToListAsync(cancellationToken);
        return _mapper.Map<GetUsersResponse>(users);
    }
}