﻿namespace Library.Contracts.Errors;

public class ValidationError
{
    public string Property { get; set; }
    public string Message { get; set; }
}