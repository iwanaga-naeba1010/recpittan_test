import axios from 'axios';
import { Bank, Branch } from '@/types';

// 外部APIからすべての銀行を取得する
export const fetchAllBanks = async (): Promise<Bank[]> => {
  let fetchedBanks: Bank[] = [];
  let currentPage = 1;

  while (currentPage <= 24) {
    const api = `https://bank.teraren.com/banks.json?page=${currentPage}`;
    const response = await axios.get(api);
    const data = response.data;

    if (data && data.length > 0) {
      fetchedBanks = fetchedBanks.concat(data);
      currentPage += 1;
    } else {
      break;
    }
  }
  return fetchedBanks;
};

// 指定された銀行コードのすべての支店を取得する
export const fetchAllBranches = async (bankCode: string): Promise<Branch[]> => {
  let allBranches: Branch[] = [];
  let currentPage = 1;
  let hasMore = true;

  while (hasMore) {
    const api = `https://bank.teraren.com/banks/${bankCode}/branches.json?page=${currentPage}`;
    const response = await axios.get(api);
    const data = response.data;

    if (data && data.length > 0) {
      allBranches = allBranches.concat(data);
      currentPage++;
    } else {
      hasMore = false;
    }
  }
  return allBranches;
};

// 指定された銀行コードと支店コードで支店情報を取得する
export const fetchBranchByCode = async (
  bankCode: string,
  branchCode: string
): Promise<Branch | null> => {
  const api = `https://bank.teraren.com/banks/${bankCode}/branches/${branchCode}.json`;
  try {
    const response = await axios.get(api);
    return response.data;
  } catch (error) {
    return null;
  }
};
