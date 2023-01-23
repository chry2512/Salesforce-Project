/**
 * @description       : 
 * @author            : Christian Niro
 * @group             : 
 * @last modified on  : 10-28-2022
 * @last modified by  : 
**/
({
    
  


    displayViaggi : function(component, event){

        var action = component.get('c.visualizerViaggio');

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){

                component.set('v.vggListDisplay', response.getReturnValue());

            }
        });
        $A.enqueueAction(action);

    },


    NewAccounts : function(component, viaggioName) {
        var action= component.get('c.createAccount');

       

        action.setParams({
            "acc" : component.get('v.AccountList')
           
        })
        
        action.setCallback(this, function(response){

            var state = response.getState();

            if(state == 'SUCCESS'){

                var toastEvent = $A.get("e.force:showToast");

                toastEvent.setParams({
                    "title" : "Success!" ,
                    "message" : "Viaggio Prenotato.",
                    "type" : "success"
                    

                });

                toastEvent.fire();

            }else if (state == "ERROR") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "Impossibile Prenotare Viaggio",
                    "type" : "error"

                });
                toastEvent.fire();
            }    
        });

        $A.enqueueAction(action);
    },


    UpdateVgg : function(component, vgg) {
        var action= component.get('c.updateViaggio');

       

        action.setParams({
            "v2Name" : vgg
        })
        
        

        $A.enqueueAction(action);
    }



    
})