({
    showProviderSearchHelper: function (component, event) {
        var modalBody;
        var modalFooter;
        var action = component.get("c.getLinkForRedirect");
        action.setParams({
            actionLabel: "MX Provider Search"
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS" && response.getReturnValue() != null) {
                var link = response.getReturnValue();
                $A.createComponents(
                    [
                        ["c:ProviderSearchLink", { recordId: component.get("v.recordId"), redirectLink: link }],
                        ["c:CancelFooter", {}]
                    ],
                    function (components, status) {
                        if (status === "SUCCESS") {
                            modalBody = components[0];
                            modalFooter = components[1];
                            component.find("overlayLib").showCustomModal({
                                header: "Provider Search",
                                body: modalBody,
                                footer: modalFooter,
                                showCloseButton: true
                            });
                        }
                    }
                );
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Error",
                    message: "No redirect link, please populate URL settings in Custom Metadata Type",
                    type: "error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    demographicUpdatesHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:DemographicUpdatesRequest",
            {
                recordId: recordId
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        header: "Enter the details of the Case",
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    benefitInquiryHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.findPlanBenefitId");
        action.setParams({
            accountId: component.get("v.recordId")
        });
        action.setCallback(this, function (response) {
            const state = response.getState();

            if (state === "SUCCESS") {
                const { status, planBenefitId } = response.getReturnValue();
                const workspaceApi = component.find("workspace");

                workspaceApi
                    .getFocusedTabInfo()
                    .then(function ({ tabId: focusedTabId }) {
                        workspaceApi.openSubtab({
                            parentTabId: focusedTabId,
                            url: `/lightning/r/PlanBenefit/${planBenefitId}/view`,
                            focus: true
                        });
                    })
                    .then(() => {
                        if (status === "Inactive") {
                            let toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title: "Notification",
                                message: "Plan Benefit is inactive for this Member!",
                                type: "warning"
                            });
                            toastEvent.fire();
                        }
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            } else {
                let errors = response.getError();
                let errorMessage = "";
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    errorMessage = errors[0].message;
                }

                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Error",
                    message: errorMessage,
                    type: "error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    createCardRequestHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:NewCardRequest",
            {
                recordId: recordId
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        header: "Enter the details of the Case",
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    updateCommunicationPreferencesHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:CommunTypeChoose",
            {
                recordId: recordId,
                communPrefInquiry: component.getReference("c.handleCommunPreferenceInquiry")
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        header: "Communication Preferences",
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    communPreferenceInquiryHelper: function (component, event) {
        var type = event.getParam("type");
        if (type === "phone") {
            var recordId = component.get("v.recordId");
            $A.createComponent(
                "c:PhoneUpdate",
                {
                    recordId: recordId
                },
                function (result, status) {
                    if (status === "SUCCESS") {
                        component.find("overlayLib").showCustomModal({
                            header: "Phone preference update",
                            body: result,
                            showCloseButton: true
                        });
                    }
                }
            );
        }
        if (type === "email") {
            var recordId = component.get("v.recordId");
            $A.createComponent(
                "c:EmailUpdate",
                {
                    recordId: recordId
                },
                function (result, status) {
                    if (status === "SUCCESS") {
                        component.find("overlayLib").showCustomModal({
                            header: "Email preference update",
                            body: result,
                            showCloseButton: true
                        });
                    }
                }
            );
        }
    },

    submitTransportationRequestHelper: function (component, event) {
        var action = component.get("c.getLinkForRedirect");
        action.setParams({
            actionLabel: "MX Transportation Request"
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS" && response.getReturnValue() != null) {
                var link = response.getReturnValue();
                console.log(link);
                window.open(link);
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Error",
                    message: "No redirect link, please populate URL settings in Custom Metadata Type",
                    type: "error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    formularySearchHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.getFormularySearchLink");
        action.setParams({
            accountId: recordId
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS" && response.getReturnValue() != null) {
                var link = response.getReturnValue();
                console.log(link);
                window.open(link);
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Error",
                    message: "No redirect link, please populate URL settings in Custom Metadata Type",
                    type: "error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    pharmacySearchHelper: function (component, event) {
        var action = component.get("c.getLinkForRedirect");
        action.setParams({
            actionLabel: "MX Pharmacy Search"
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS" && response.getReturnValue() != null) {
                var link = response.getReturnValue();
                console.log(link);
                window.open(link);
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Error",
                    message: "No redirect link, please populate URL settings in Custom Metadata Type",
                    type: "error"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    createSessionEventHelper: function (component, sessionEvent) {
        var action = component.get("c.createSessionEvent");
        action.setParams({ eventLabel: sessionEvent });
        $A.enqueueAction(action);
    },

    deceasedMemberHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:DeceasedMember",
            {
                recordId: recordId
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    covidVaccineHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:CovidVaccineInfo",
            {
                recordId: recordId
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    temporaryConsentHelper: function (component, event) {
        var recordId = component.get("v.recordId");
        $A.createComponent(
            "c:TemporaryConsent",
            {
                recordId: recordId
            },
            function (result, status) {
                if (status === "SUCCESS") {
                    component.find("overlayLib").showCustomModal({
                        header: "Temporary Consent",
                        body: result,
                        showCloseButton: true
                    });
                }
            }
        );
    },

    closeBenefitInquiryModalHelper: function (component, event) {
        component.set("v.isBenefitInquiryModalOpen", false);
        component.set("v.isPharmacyInfoActive", false);
    },

    closeStartModal: function (component, event) {
        var closeEvent = component.getEvent("closePopup");
        closeEvent.fire();
    },

    showMemberVerificationPopup: function (component, event) {
        component
            .find("utilInquiry")
            .getEnclosingUtilityId()
            .then((utilityId) => {
                $A.createComponent(
                    "c:MemberVerificationPopupWrapper",
                    {
                        utilInquiryId: utilityId,
                        verified: component.getReference("c.handleMemberVerified")
                    },
                    function (result, status) {
                        if (status === "SUCCESS") {
                            component.find("overlayLib").showCustomModal({
                                header: "Verify the Member",
                                body: result,
                                showCloseButton: true
                            });
                        }
                    }
                );
            });
    },

    openVerifiedMemberRecordInNewTab: function (component, event) {
        const memberId = event.getParam("memberId");
        const workspaceAPI = component.find("workspace");

        if (memberId) {
            workspaceAPI
                .openTab({
                    url: "#/sObject/" + memberId + "/view"
                })
                .then(function (response) {
                    workspaceAPI.focusTab({ tabId: response });
                })
                .catch(function (error) {
                    console.log(error);
                });
        }
    }
});
