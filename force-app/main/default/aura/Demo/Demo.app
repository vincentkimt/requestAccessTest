<aura:application extends="force:slds">

<div class ="slds-text-heading_large slds-text-align_center slds-box">
    Lightning Component

</div>

<div class="slds-grid slds-grid_vertical">
   
        <div class="slds-col">
            <span>
                <c:greetTextLWC/>
            </span>
            <br/>
            <center>-------------End of Component-------------</center>
            <br/>
        </div>  

        <div class="slds-col"> 
       <span><c:EventDemo /></span> 
       <br/>
       <center>-------------End of Component-------------</center>
       <br/>

        </div>


        <div class="slds-col">

           <br/>
           <center>-------------End of Component-------------</center>
           <br/>
                <c:dSDemo />

        </div>
        <div class="slds-col">

            <br/>
            <center>-------------End of Component-------------</center>
            <br/>
                <c:lWC_GetAccounts />

        </div>
</div>


</aura:application>	

