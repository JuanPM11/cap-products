namespace com.logali;

type name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;
}

entity Car {
    key ID                 : UUID;
        name               : String;
        virtual discount_1 : Decimal;
        discount_2         : Decimal;

}

//type EmailAdresses_01 : array of {
//   kind  : String;
//  email : String;
//}

//entity Emails {
//  email_01 : EmailAdresses_01;
//}

// type Gender  : String enum{
//     male;
//     female;
// }

// entity Order {
//     clientOrder : Gender;
//     status : Integer enum{
//         submitted = 1;
//         fulfiller =2;
//         shipped = 3;
//         cancel = -1;

//     };
//     priority : String @assert.range enum{
//         high ;
//         medium;
//         low;
//     }
// }

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier_Id      : UUID;
        ToSupplier       : Association to one Suppliers
                               on ToSupplier.ID = Supplier_Id;

}

entity Suppliers {
    key ID      : UUID;
        Name    : type of Products : Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
}


entity Categories {
    key ID   : String(1);
        Name : String;

}

entity StockAvailability {
    key ID          : Integer;
        Description : String;

}

entity Currencies {
    key ID          : String(3);
        Description : String;

}

entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;

}

entity DimensionUnits {
    key ID          : String(2);
        Description : String;

}

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);

}

entity ProductReview {
    key Name    : String;
        Rating  : Integer;
        Comment : String;

}

entity SalesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);


}

entity SelProducts   as select from Products;

entity SelProducts1  as
    select from Products {
        *

    };


entity SelProducts2  as
    select from Products {
        Name,
        Price,
        Description

    };

entity SelProducts3  as
    select from Products
    left join ProductReview
        on Products.Name = ProductReview.Name
    {
        Rating,
        Products.Name,
        Sum(Price) as totalPrice
    }
    group by
        Rating,
        Products.Name
    order by
        Rating;

entity ProjProducts  as projection on Products;

entity ProjProducts2 as
    projection on Products {
        *
    };

entity ProjProducts3 as
    projection on Products {
        ReleaseDate,
        Name
    };


// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Description
//     }
//     where
//         Name = :pName;

// entity projParamProducts (pName : String) as projection on Products where Name = :pName;
