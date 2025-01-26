namespace Library.Contracts.Responses;

public class Response
{
    public bool Succeeded { get; set; }
    public string? Message { get; set; }

    public static Response Success()
    {
        return new Response { Succeeded = true };
    }

    public static Response Fail(string message)
    {
        return new Response { Succeeded = false, Message = message };
    }
}

public class Response<T> : Response
{
    public T? Data { get; set; }

    public static Response<T> Success(T data)
    {
        return new Response<T> { Succeeded = true, Data = data };
    }

    public static Response<T> Fail(string message)
    {
        return new Response<T> { Succeeded = false, Message = message };
    }
}