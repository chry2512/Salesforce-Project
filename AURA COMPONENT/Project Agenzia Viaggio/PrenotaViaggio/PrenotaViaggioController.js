/**
 * @description       : 
 * @author            : Christian Niro
 * @group             : 
 * @last modified on  : 10-28-2022
 * @last modified by  : 
**/
({
    

    VisualizerViaggi : function(component, event,helper){
        helper.displayViaggi(component, event);

    },

    onClear : function(component, event, helper) {

         var vgg = event.getSource().get("v.name");
        
         helper.UpdateVgg(component, vgg);

         window.setTimeout(function(){ $A.get('e.force:refreshView').fire(); }, 1); 
         window.location.href = "/lightning/n/trivago2";
         

     },

    CreateAccounts : function(component, event, helper) {
        helper.NewAccounts(component);
    }

   
})
