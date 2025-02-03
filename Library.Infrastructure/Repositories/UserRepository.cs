using Library.Domain.Models;
using Library.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Library.Infrastructure.Repositories;

public class UserRepository : IUserRepository
{
    private readonly LibraryDbContext _context;

    public UserRepository(LibraryDbContext context)
    {
        _context = context;
    }

    public async Task<User?> GetById(int id, CancellationToken token)
    {
        return await _context.Users.FirstOrDefaultAsync(u => u.Id == id && u.IsActive, token);
    }

    public async Task<List<User>> GetAll(CancellationToken token)
    {
        return await _context.Users
            .Where(u => u.IsActive)
            .ToListAsync(token);
    }

    public async Task Add(User user, CancellationToken token)
    {
        await _context.Users.AddAsync(user, token);
    }

    public void Update(User user)
    {
        _context.Users.Update(user);
    }

    public void Delete(User user)
    {
        user.IsActive = false;
        _context.Users.Update(user);
    }

    public async Task<bool> CanBeDeleted(User user, CancellationToken token)
    {
        var hasOutstandingCheckouts = await _context
            .Checkouts
            .AnyAsync(c => c.UserId == user.Id && c.ReturnedDate == null, token);

        var hasUnpaidFees = await _context
            .Fees
            .AnyAsync(f => f.UserId == user.Id && !f.Paid, token);

        return !hasOutstandingCheckouts && !hasUnpaidFees;
    }
}