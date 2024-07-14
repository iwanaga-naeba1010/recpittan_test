import { createRoot } from 'react-dom/client';
import React, { useState, useEffect } from 'react';
import { useForm, FormProvider, useFormContext } from 'react-hook-form';
import { Bank, Branch } from '@/types';
import { useBankAccount } from '../hook/useBankAccount';

const BankAccountEdit: React.FC<{ id: string }> = ({ id }) => {
  const {
    register,
    handleSubmit,
    setValue,
    formState: { errors, isSubmitted },
  } = useFormContext();
  const { fetchBankAccount, updateBankAccount } = useBankAccount();

  const [bankName, setBankName] = useState('');
  const [suggestedBanks, setSuggestedBanks] = useState<Bank[]>([]);
  const [isFocused, setIsFocused] = useState(false);
  const [isSuggestedOpen, setIsSuggestedOpen] = useState(true);
  const [bankCode, setBankCode] = useState('');
  const [branchCode, setBranchCode] = useState('');
  const [branchName, setBranchName] = useState('');
  const [allBanks, setAllBanks] = useState<Bank[]>([]);

  useEffect(() => {
    const fetchAllBanks = async () => {
      let fetchedBanks: Bank[] = [];
      let currentPage = 1;

      while (currentPage <= 24) {
        const api = `https://bank.teraren.com/banks.json?page=${currentPage}`;
        const response = await fetch(api);
        const data = await response.json();

        if (data && data.length > 0) {
          fetchedBanks = fetchedBanks.concat(data);
          currentPage += 1;
        } else {
          break;
        }
      }
      setAllBanks(fetchedBanks);
    };
    fetchAllBanks();
  }, []);

  useEffect(() => {
    const fetchBankData = async () => {
      const bankAccount = await fetchBankAccount(id);
      setValue('bankName', bankAccount.bankName);
      setValue('bankCode', bankAccount.bankCode);
      setValue('branchName', bankAccount.branchName);
      setValue('branchCode', bankAccount.branchCode);
      setValue('accountType', bankAccount.accountType);
      setValue('accountNumber', bankAccount.accountNumber);
      setValue('accountHolderName', bankAccount.accountHolderName);
    };
    fetchBankData();
  }, [id, fetchBankAccount, setValue]);

  const handleBankNameInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setIsSuggestedOpen(true);
    const value = e.target.value;
    setBankName(value);

    if (value) {
      const filteredData = allBanks.filter(
        (bank) =>
          bank.name.includes(value) ||
          bank.hira.includes(value) ||
          bank.kana.includes(value)
      );
      setSuggestedBanks(filteredData);
    } else {
      setSuggestedBanks([]);
    }
  };

  const handleFocus = () => {
    setIsFocused(true);
  };
  const handleBlur = () => {
    setIsFocused(false);
  };

  const bankNameMessage = () => {
    if (!isFocused && bankName.length === 0) return null;
    if (bankName.length === 0 || suggestedBanks.length === 0) {
      return <li className='error-text'>該当の銀行は見つかりません</li>;
    }
    return suggestedBanks.map((bank) => (
      <li
        key={bank.code}
        className='bank-name'
        onClick={() => handleBankNameClick(bank.name, bank.code)}
      >
        {bank.name}銀行
      </li>
    ));
  };

  const handleBankNameClick = (name: string, code: string) => {
    setBankName(name);
    setBankCode(code);
    setSuggestedBanks([]);
    setIsSuggestedOpen(false);
    setValue('bankName', name);
    setValue('bankCode', code);
  };

  const fetchAllBranches = async (bankCode: string): Promise<Branch[]> => {
    let allBranches: Branch[] = [];
    let currentPage = 1;
    let hasMore = true;

    while (hasMore) {
      const api = `https://bank.teraren.com/banks/${bankCode}/branches.json?page=${currentPage}`;
      const response = await fetch(api);
      const data = await response.json();

      if (data && data.length > 0) {
        allBranches = allBranches.concat(data);
        currentPage++;
      } else {
        hasMore = false;
      }
    }
    return allBranches;
  };

  const handleBranchNameChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setBranchName(value);
    setValue('branchName', value);

    if (bankCode.length === 4) {
      const branches = await fetchAllBranches(bankCode);
      const branch = branches.find((branch) => branch.name.includes(value));
      if (branch) {
        setBranchCode(branch.code);
        setValue('branchCode', branch.code);
      } else {
        setBranchCode('');
        setValue('branchCode', '');
      }
    }
  };

  const handleBranchCodeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setBranchCode(value);
    setValue('branchCode', value);

    if (bankCode.length === 4 && value.length === 3) {
      fetch(`https://bank.teraren.com/banks/${bankCode}/branches/${value}.json`)
        .then((response) => response.json())
        .then((json) => {
          setBranchName(json.name);
          setValue('branchName', json.name);
        })
        .catch(() => {
          setBranchName('');
          setValue('branchName', '');
        });
    }
  };

  const onSubmit = async (data: any) => {
    try {
      await updateBankAccount(id, { bank_account: data });
      alert('Bank account updated successfully');
    } catch (error) {
      console.error(error);
      alert('Failed to update bank account');
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-75 bg-black'></div>
      </div>
      <div className='p-3'>
        {isSubmitted && Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.bankName && <li>{errors.bankName.message as string}</li>}
              {errors.bankCode && <li>{errors.bankCode.message as string}</li>}
              {errors.branchName && <li>{errors.branchName.message as string}</li>}
              {errors.branchCode && <li>{errors.branchCode.message as string}</li>}
              {errors.accountType && <li>{errors.accountType.message as string}</li>}
              {errors.accountNumber && <li>{errors.accountNumber.message as string}</li>}
              {errors.accountHolderName && <li>{errors.accountHolderName.message as string}</li>}
            </ul>
          </div>
        )}
        <div className='mb-2'>
          <p className='small mb-1 text-black'>金融機関</p>
          <input
            id='searchBank'
            className='w-100 p-2'
            placeholder='銀行名を検索する'
            value={bankName}
            {...register('bankName', { required: '金融機関名は必須です' })}
            onChange={handleBankNameInputChange}
            onFocus={handleFocus}
            onBlur={handleBlur}
          />
          {isSuggestedOpen && (
            <ul className='bank-name-suggested'>{bankNameMessage()}</ul>
          )}
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>金融機関コード(4桁半角数字)</p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='0001'
            value={bankCode}
            {...register('bankCode', {
              required: '金融機関コードは必須です',
              pattern: {
                value: /^\d{4}$/,
                message: '4桁の半角数字を入力してください',
              },
            })}
            readOnly
          />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>支店名</p>
          <input
            id='inputBranchName'
            className='w-100 p-2'
            placeholder='例）丸の内中央'
            type='text'
            value={branchName}
            {...register('branchName', { required: '支店名は必須です' })}
            onChange={handleBranchNameChange}
          />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>支店コード（半角数字）</p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='001'
            value={branchCode}
            {...register('branchCode', {
              required: '支店コードは必須です',
              pattern: {
                value: /^\d{3}$/,
                message: '3桁の半角数字を入力してください',
              },
            })}
            onChange={handleBranchCodeChange}
          />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>預金種目</p>
          <select
            id='accountType'
            className='w-100 p-2'
            {...register('accountType', { required: '預金種目は必須です' })}
          >
            <option value='checking'>普通</option>
            <option value='current'>当座</option>
          </select>
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>口座番号</p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='1234567'
            {...register('accountNumber', {
              required: '口座番号は必須です',
              pattern: {
                value: /^\d{1,7}$/,
                message: '7桁以内の半角数字を入力してください',
              },
            })}
          />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>口座名義(カタカナ)</p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='エブリタロウ'
            {...register('accountHolderName', {
              required: '口座名義は必須です',
              pattern: {
                value: /^[ァ-ヶー]+$/,
                message: 'カタカナで入力してください',
              },
            })}
          />
        </div>

        <button type='submit' className='btn btn-primary'>口座更新</button>
      </div>
    </form>
  );
};

const App: React.FC<{ id: string }> = ({ id }) => {
  const methods = useForm();

  return (
    <FormProvider {...methods}>
      <BankAccountEdit id={id} />
    </FormProvider>
  );
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#bankAccountEdit');
  if (elm) {
    const root = createRoot(elm);
    const id = elm.getAttribute('data-id'); // IDを取得する
    if (id) {
      root.render(<App id={id} />);
    }
  }
});

$(document).ready(() => {
  const elm = document.querySelector('#bankAccountEdit');
  if (elm) {
    const root = createRoot(elm);
    const id = elm.getAttribute('data-id'); // IDを取得する
    if (id) {
      root.render(<App id={id} />);
    }
  }
});

export default BankAccountEdit;
