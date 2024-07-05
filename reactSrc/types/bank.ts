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
