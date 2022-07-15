({
    demographicUpdates: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Demographic updates");
        helper.closeStartModal(component, event);
        helper.demographicUpdatesHelper(component, event);
    },

    showProviderSearch: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Provider Search");
        helper.closeStartModal(component, event);
        helper.showProviderSearchHelper(component, event);
    },

    openBenefitInquiryModal: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Benefit inquiry");
        component.set("v.isBenefitInquiryModalOpen", true);
    },

    closeBenefitInquiryModal: function (component, event, helper) {
        helper.closeBenefitInquiryModalHelper(component, event);
    },

    showPharmacyInfo: function (component, event, helper) {
        component.set("v.isPharmacyInfoActive", true);
    },

    formularySearch: function (component, event, helper) {
        helper.closeBenefitInquiryModalHelper(component, event);
        helper.closeStartModal(component, event);
        helper.formularySearchHelper(component, event);
    },

    pharmacySearch: function (component, event, helper) {
        helper.closeBenefitInquiryModalHelper(component, event);
        helper.closeStartModal(component, event);
        helper.pharmacySearchHelper(component, event);
    },

    benefitInquiry: function (component, event, helper) {
        helper.closeBenefitInquiryModalHelper(component, event);
        helper.closeStartModal(component, event);
        helper.benefitInquiryHelper(component, event);
    },

    createCardRequest: function (component, event, helper) {
        helper.createSessionEventHelper(component, "New ID card request");
        helper.closeStartModal(component, event);
        helper.createCardRequestHelper(component, event);
    },

    updateCommunicationPreferences: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Update Communication Preferences");
        helper.closeStartModal(component, event);
        helper.updateCommunicationPreferencesHelper(component, event);
    },

    handleCommunPreferenceInquiry: function (component, event, helper) {
        helper.communPreferenceInquiryHelper(component, event);
    },

    submitTransportationRequest: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Submit Transportation Request");
        helper.submitTransportationRequestHelper(component, event);
    },

    deceasedMember: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Deceased Member");
        helper.closeStartModal(component, event);
        helper.deceasedMemberHelper(component, event);
    },

    covidVaccine: function (component, event, helper) {
        helper.createSessionEventHelper(component, "Covid Vaccine Information");
        helper.closeStartModal(component, event);
        helper.covidVaccineHelper(component, event);
    },

    temporaryConsent: function (component, event, helper) {
        helper.closeStartModal(component, event);
        helper.temporaryConsentHelper(component, event, helper);
    },

    verifyAnotherMember: function (component, event, helper) {
        helper.closeStartModal(component, event);
        helper.showMemberVerificationPopup(component, event);
    },

    handleMemberVerified: function (component, event, helper) {
        helper.openVerifiedMemberRecordInNewTab(component, event);
    }
});
