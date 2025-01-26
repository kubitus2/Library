using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class OrderDetail
{
    public int Id { get; set; }

    public int? BookCopyId { get; set; }

    public int? OrderId { get; set; }

    public virtual BookCopy? BookCopy { get; set; }

    public virtual Order? Order { get; set; }
}