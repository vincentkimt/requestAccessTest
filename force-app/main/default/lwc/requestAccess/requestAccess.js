import { LightningElement,track,api } from 'lwc';
import verifyVAT from '@salesforce/apex/requestAccessCustomerHandler.verifyVAT';
import insertCustomer from '@salesforce/apex/requestAccessCustomerHandler.insertCustomer';

export default class RequestAccessCustomer extends LightningElement {
    
    
    @track enableSubmitButton=false;
   
    @track showErrorMessage=false;
    @track successMessage;
    @track mapData = [];
    @track companyName;
    @track country;
    @track companyAddress;
    @track companyZipCode;
    @track companyCity;
    @track region;
    @track companyEmail;
    @track vatNumber;
    @track errorMsg;
    @track mandatoryFields;
    @track showErroricon=false;
    @api isLoaded = false;
    verifyVATNumber(event){
        this.isLoaded=true;
        this.vatNumber=event.target.value;
        this.mapData=[];
     this.enableSubmitButton=false;
        this.showErrorMessage=false;
     let vatNum=event.target.value;
      
     
      let vatString = vatNum.toString();
     
      if(vatNum.toString().length == 10){
        this.showErroricon=false;
        let vatNum=this.template.querySelector(".vatnumberclass");

        vatNum.setCustomValidity("");
    
        vatNum.reportValidity();

        verifyVAT({ searchKey: vatString })
            .then((result) => {
                this.vatnumber=vatString;
                if(result){
                   
                   if (result) {
                    for (let key in result) {
                       this.mapData.push({value:result[key], key:key});
                       if(key=='Status' && result[key]=='Valid'){
                        this.enableSubmitButton=true;
                        this.isLoaded=false;

                       }else if(key=='Status' && result[key]=='Invalid VAT number'){
                        this.isLoaded=false;

                           this.showErrorMessage=true;
                           this.showErroricon=true;

                       }
                    }
                    } else if (error) {
                        window.console.log(error);
                    }
                    
                    
                }else{
                    this.enableSubmitButton=false;
                    this.showErrorMessage=true;
                    this.isLoaded=false;
                    this.showErroricon=false;
                    console.log('error here ');
                    console.log(result);
                }
            })
            .catch((error) => {
                this.enableSubmitButton=false;
                this.showErrorMessage=true;
                this.isLoaded=false;
                console.log('error here catch');
                    console.log(error);

            });
      }else{
        let vatNum=this.template.querySelector(".vatnumberclass");

            vatNum.setCustomValidity("Please Enter 10 Digit VAT number");
            this.showErroricon=true;
            vatNum.reportValidity();
            this.isLoaded=false;

      }
    }
    get optionsCountry() {
        return [
            { label: 'USA', value: 'USA' },
            { label: 'UK', value: 'UK' },
            { label: 'Singapore', value: 'Singapore' },
        ];
    }
    get optionsRegion() {
        return [
            { label: 'Asia', value: 'Asia' },
            { label: 'America', value: 'America' },
            { label: 'Europe', value: 'Europe' },
        ];
    }

    submitForm(){
        let parameterObject = {
            companyName: this.companyName,
            country: this.country,
            companyAddress: this.companyAddress,
            companyZipCode: this.companyZipCode,
            companyCity: this.companyCity,
            region: this.region,
            companyEmail: this.companyEmail,
            vatNumber: this.vatNumber
        };
        console.log('params');
        console.log(this.companyName);
        console.log(this.country);
        console.log(this.companyZipCode);
        console.log(this.companyCity);
        console.log(this.region);
        console.log(this.vatNumber);
        console.log(this.companyEmail);

        if(this.companyName == undefined || this.country == undefined  ||
            this.companyZipCode == undefined  || this.companyCity == undefined  ||
             this.region == undefined  ||
             this.vatNumber == undefined || this.companyEmail == undefined){
                 console.log('here');
            this.mandatoryFields=true;
        }else{
            
        insertCustomer({ wrapper:parameterObject })
            .then((result) => {
                console.log(result);
                this.companyName='';
                this.country='';
                this.companyAddress='';
                this.companyZipCode='';
                this.companyCity='';
                this.region='';
                this.vatNumber='';
                this.companyEmail='';
                this.enableSubmitButton=false;
                this.showErrorMessage=false;
                this.mandatoryFields=false;
            })
            .catch((error) => {
                this.enableSubmitButton=false;
                this.showErrorMessage=true;
                
                this.mandatoryFields=false;
                 
            });
        }
    }



    /*connectedCallback(){
        getCountryOptions().then((result) => {
            if(result){
                console.log()
            }
        })
        .catch((error) => {

        })
    }*/
    handleChangeCompanyName(event){
        this.companyName=event.target.value;
    }
    handleChangeCountry(event){
        this.country=event.target.value;
    }
    handleChangeCompanyAddress(event){
        this.companyAddress=event.target.value;
    }
    handleChangeCompanyZipCode(event){
        this.companyZipCode=event.target.value;
    }
    handleChangeCompanyCity(event){
        this.companyCity=event.target.value;
    }
    handleChangeRegion(event){
        this.region=event.target.value;
    }
    handleChangeCompanyEmail(event){
        const emailRegex=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        let email=this.template.querySelector(".email");
        let emailVal=email.value;
        
        if(emailVal.match(emailRegex)){
            this.companyEmail=emailVal;
            console.log('email entered is');
        console.log(emailVal);
            email.setCustomValidity("");

        }else{
            email.setCustomValidity("Please enter valid email");
        }
        email.reportValidity();

    }
}