export interface PartnerInfo {
  phoneNumber: string;
  postalCode: string;
  prefecture: string;
  city: string;
  address1: string;
  address2?: string;
  companyName: string;
}

export interface Partner {
  id: number;
  email: string;
  username: string;
  usernameKana: string;
  partnerInfo: PartnerInfo;
}
