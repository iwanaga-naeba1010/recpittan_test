export interface Bank {
  name: string;
  code: string;
  hira: string;
  kana: string;
  normalize: {
    name: string;
  };
  branches?: Branch[];
}

export interface Branch {
  name: string;
  code: string;
}

export interface BankAccount {
  bankName: string;
  bankCode: string;
  branchName: string;
  branchCode: string;
  accountType: string;
  accountNumber: string;
  accountHolderName: string;
}
