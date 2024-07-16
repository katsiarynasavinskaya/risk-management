
using {riskmanagement as rm} from '../db/schema';

@path: 'service/item'
service ItemService  {
    

entity Item       as projection on rm.Item actions{
    function hello() returns String;
} ;
        action addItem(descr: String, title: String, quantity:Integer);
        function getItemsByQuantity(quantity: Integer) returns many Item;

    annotate Item with @odata.draft.enabled;

}
