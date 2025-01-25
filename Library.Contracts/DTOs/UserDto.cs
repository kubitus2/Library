namespace Library.Contracts.DTOs;

public record UserDto(int Id, string FirstName, string LastName, string Email, string PhoneNumber, bool IsLocked);
