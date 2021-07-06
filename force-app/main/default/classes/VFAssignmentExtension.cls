public class VFAssignmentExtension {
    
    public List<SelectOption> pickListProductFamilyList {get;set;}
    public String selectedProductFamily {get;set;}
    public List<SelectOption> productList {get;set;}
    public String selectedProduct {set;get;}
    public List<Product2> selectedItemDetailsList {get;set;}
    public Boolean addToCartButtonFlag {get;set;}
    public Product2 productAddToCart {get;set;}
    public Integer quantity {set;get;}
    public List<CartWrapper> cartWrapperList {get;set;}
    public String productInCartId {set;get;}
    public String idToRecalculate {set;get;}
    public Double grandTotal {get;set;}
    public Integer grandQty {get;set;}
    public Boolean firstTime = true;
    public String conId {get;set;}
    public Contact cont {get;set;}
    public VFAssignmentExtension(ApexPages.StandardController stdController){
        addToCartButtonFlag = false;
        grandTotal = 0;
        grandQty = 0;
        pickListProductFamilyList= new List<SelectOption>();
        selectedItemDetailsList = new List<Product2>();
        cartWrapperList = new List<CartWrapper>();
        cont= new Contact();
        cont = (Contact) stdController.getRecord();
        System.debug('Id of cont. '+cont.Id);
        
        Schema.DescribeFieldResult fieldResult = Product2.Family.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            if(!('None'== pickListVal.getLabel())){
                pickListProductFamilyList.add(new SelectOption(pickListVal.getValue(),pickListVal.getLabel()));
            }
            else{
                pickListProductFamilyList.add(new SelectOption('',pickListVal.getLabel()));
                
            }
        }            
        
    }
    
    public void fetchSelectedProduct(){
        productList=new List<SelectOption>();
        List<String> inQuery = new List<String>();
        inQuery.add(selectedProductFamily);
        productList.add(new SelectOption('','None'));
        if(!String.isBlank(selectedProductFamily)){
            for(Product2 prod : [SELECT Id,Name FROM Product2 WHERE Family IN: inQuery]){
                
                productList.add(new SelectOption(prod.Id,prod.Name));
            }
        }
        
        
        
    }
    
    public void getProductDetail(){
        //selectedItemDetailsList = new List<Product2>();
        if(!String.isBlank(selectedProduct)){
            for(Product2 prod : [SELECT Id, Name, Family, Price__c FROM Product2 WHERE Id =: selectedProduct]){
                
                selectedItemDetailsList.add(prod);
            }
            
            
        }
    }
    
    public void addToCart(){
        addToCartButtonFlag=true;//REMOVE
        // cartWrapperList = new List<CartWrapper>();
        for(Product2 prod : [SELECT Id, Name, Price__c FROM Product2 WHERE Id =: productInCartId]){
            cartWrapperList.add(new CartWrapper(prod));
            if(firstTime){ 
                grandTotal=prod.Price__c;
                grandQty=1;
                firstTime = false;
            }else{
                grandTotal=grandTotal + prod.Price__c;
                grandQty=grandQty + 1;
            }
            
        }
        System.debug('in addtocart'+cartWrapperList);
    }
    public void recalculateTotal(){
        grandQty=0;
        grandTotal=0;
        for(CartWrapper cw : cartWrapperList){
            cw.total = cw.quantity * cw.product.Price__c;
            grandTotal=grandTotal + cw.total;
            grandQty = grandQty + cw.quantity;
            System.debug('new total = ' +cw.total+' and qty = '+cw.quantity+' and price =  '+
                         cw.product.Price__c+' and grandtotal = '+grandTotal);
            
        }
        System.debug('Hel=' +idToRecalculate);
    }
    
    public void placeOrder(){
        Purchase_Summary__c ps = new Purchase_Summary__c();
        ps.Customer__c=cont.Id;
        
        System.debug('contactId = '+cont.Id);
        Double totalPO=0;
        Integer qtyPO=0;
        for(CartWrapper cw : cartWrapperList){
            totalPO = totalPO+cw.total;
            qtyPO = qtyPO + cw.quantity;
            
        }
        ps.Total__c=totalPO;
        ps.Total_Items__c=qtyPO;
        System.debug('total ='+totalPO);
        System.debug('qty ='+qtyPO);
        Insert ps;
        Purchase_Summary_Item__c psi = new Purchase_Summary_Item__c();
        psi.Purchase_Order__c=ps.Id;
        psi.Quantity__c=qtyPO;
        psi.Total__c=totalPO;
        Insert psi;
    }
    
    public class CartWrapper{
        
        public Product2 product {get;set;}
        public Integer quantity {get;set;}
        public Double total {get;set;}
        public String idOfRow;
        public CartWrapper(Product2 prod){
            
            product=new Product2();
            product = prod;
            quantity = 1;
            total = product.Price__c;
        }
    }
}