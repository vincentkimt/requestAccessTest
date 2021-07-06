<aura:application >
    <aura:attribute name="isBounded" type="Boolean" default="true" />
    <aura:attribute name="buttonLabel" type="String" default="Show Unbounded" />
    
    <ui:button label="{!v.buttonLabel}" press="{!c.doToggle}" />
    
    <aura:if isTrue="{!v.isBounded}">
        <c:Demo6BoundedCmp />
    <aura:set attribute="else">
        <c:Demo6UnBoundedCmp />
    </aura:set>
  </aura:if> 
</aura:application>