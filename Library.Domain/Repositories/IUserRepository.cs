using Library.Domain.Models;

namespace Library.Domain.Repositories;

public interface IUserRepository
{
    Task<User?> GetById(int id, CancellationToken token);
    Task<List<User>> GetAll(CancellationToken token);
    Task Add(User user, CancellationToken token);
    void Update(User user);
    void Delete(User user);
    Task<bool> CanBeDeleted(User user, CancellationToken token);
}