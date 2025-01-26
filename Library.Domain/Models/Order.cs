using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class Order
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public DateOnly OrderDate { get; set; }

    public int AddressId { get; set; }

    public virtual Address Address { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual User User { get; set; } = null!;
}