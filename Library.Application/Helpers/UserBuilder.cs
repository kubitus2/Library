using Library.Domain.Models;

namespace Library.Application.Helpers;

public class UserBuilder
{
    private User _user = new();

    public UserBuilder Copy(User copy)
    {
        _user = copy;
        return this;
    }

    public UserBuilder WithFirstName(string name)
    {
        _user.FirstName = name;
        return this;
    }

    public UserBuilder WithLastName(string name)
    {
        _user.LastName = name;
        return this;
    }

    public UserBuilder WithEmail(string email)
    {
        _user.Email = email;
        return this;
    }

    public UserBuilder WithPhone(string phone)
    {
        _user.Phone = phone;
        return this;
    }

    private User Build() => _user;

    public static implicit operator User(UserBuilder builder) 
        => builder.Build();
}