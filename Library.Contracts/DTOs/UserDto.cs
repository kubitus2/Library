namespace Library.Contracts.DTOs;

public record UserDto
{
    public int Id { get; init; }
    public string FirstName { get; init; }
    public string LastName { get; init; }
    public string Email { get; init; }
    public string Phone { get; init; }
    public bool IsLocked { get; init; }
    public UserDto() { }
}
