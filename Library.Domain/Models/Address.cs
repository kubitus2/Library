using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class Address
{
    public int Id { get; set; }

    public string Street { get; set; } = null!;

    public string BuildingNumber { get; set; } = null!;

    public string? FlatNumber { get; set; }

    public string PostalCode { get; set; } = null!;

    public string City { get; set; } = null!;

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}