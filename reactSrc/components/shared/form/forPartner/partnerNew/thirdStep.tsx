import React, { useState, useEffect } from 'react';
import { useFormContext } from 'react-hook-form';
import { Bank, Branch } from '@/types';

export const ThirdStep: React.FC = () => {
  const {
    register,
    setValue,
    formState: { errors, isSubmitted },
  } = useFormContext();

  const [bankName, setBankName] = useState('');
  const [suggestedBanks, setSuggestedBanks] = useState<Bank[]>([]);
  const [isFocused, setIsFocused] = useState(false);
  const [isSuggestedOpen, setIsSuggestedOpen] = useState(true);
  const [bankCode, setBankCode] = useState('');
  const [branchCode, setBranchCode] = useState('');
  const [branchName, setBranchName] = useState('');
  const [allBanks, setAllBanks] = useState<Bank[]>([]);

  // 銀行情報を取得
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

  // 銀行名検索で、入力値に一致するデータをサジェストで表示させる
  const handleBankNameInputChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
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

  // focusを判定
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

  // サジェストされた銀行名を選択
  const handleBankNameClick = (name: string, code: string) => {
    setBankName(name);
    setBankCode(code);
    setSuggestedBanks([]);
    setIsSuggestedOpen(false);
    setValue('bankName', name);
    setValue('bankCode', code);
  };

  // 選択した金融機関コードを基に全支店情報を取得
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

  // 支店名入力
  const handleBranchNameChange = async (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
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

  // 支店コード入力
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

  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-75 bg-black'></div>
      </div>
      <div className='p-3'>
        {isSubmitted && Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.bankName && <li>{errors.bankName.message as string}</li>}
              {errors.bankCode && <li>{errors.bankCode.message as string}</li>}
              {errors.branchName && (
                <li>{errors.branchName.message as string}</li>
              )}
              {errors.branchCode && (
                <li>{errors.branchCode.message as string}</li>
              )}
              {errors.accountType && (
                <li>{errors.accountType.message as string}</li>
              )}
              {errors.accountHolderName && (
                <li>{errors.accountHolderName.message as string}</li>
              )}
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
            <option value='普通'>普通</option>
            <option value='当座'>当座</option>
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
      </div>
    </>
  );
};
