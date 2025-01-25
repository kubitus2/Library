using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class BookCopy
{
    public int Id { get; set; }

    public int BookId { get; set; }

    public int Availability { get; set; }

    public virtual AvailabilityStatus AvailabilityNavigation { get; set; } = null!;

    public virtual Book Book { get; set; } = null!;

    public virtual ICollection<Checkout> Checkouts { get; set; } = new List<Checkout>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
