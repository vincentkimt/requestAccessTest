<aura:application >
     <aura:attribute type="String" name="applabel" default="application label"/>
    <aura:attribute type="Decimal" name="appamount" default="0.5"/>
   
    <c:Demo1AttrubuteFeb19/>
    <br></br><br></br>
    <c:Demo1AttrubuteFeb19 label="{!v.applabel}" amount="{!v.appamount}"/>
</aura:application>