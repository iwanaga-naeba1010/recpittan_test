import React, { useState, useEffect } from 'react';
import { useFormContext } from 'react-hook-form';
import { Bank } from '@/types';
import { useBankApi } from '@/utils/bank';

interface BankAccountFormProps {
  onSubmit: (data: any) => void;
  initialData?: any;
}

const BankAccountForm: React.FC<BankAccountFormProps> = ({
  onSubmit,
  initialData,
}) => {
  const {
    register,
    handleSubmit,
    setValue,
    watch,
    formState: { errors, isSubmitted },
  } = useFormContext();

  const { fetchAllBanks, fetchAllBranches, fetchBranchByCode } = useBankApi();

  const [bankName, setBankName] = useState(initialData?.bankName || '');
  const [suggestedBanks, setSuggestedBanks] = useState<Bank[]>([]);
  const [isFocused, setIsFocused] = useState(false);
  const [isSuggestedOpen, setIsSuggestedOpen] = useState(true);
  const [bankCode, setBankCode] = useState(initialData?.bankCode || '');
  const [branchCode, setBranchCode] = useState(initialData?.branchCode || '');
  const [branchName, setBranchName] = useState(initialData?.branchName || '');
  const [allBanks, setAllBanks] = useState<Bank[]>([]);
  const [isCorporate, setIsCorporate] = useState(initialData?.isCorporate || false);
  const [isInvoice, setIsInvoice] = useState(initialData?.isInvoice || false);

  useEffect(() => {
    const fetchBanks = async () => {
      const banks = await fetchAllBanks();
      setAllBanks(banks);
    };
    fetchBanks();
  }, [fetchAllBanks]);

  useEffect(() => {
    if (initialData) {
      setIsCorporate(initialData.isCorporate || false);
      setIsInvoice(initialData.isInvoice || false);
    }
  }, [initialData]);

  const handleCorporateChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const value = event.target.value === "true";
    setIsCorporate(value);
    setValue('isCorporate', value);
    
    if (!value) {
      setValue('corporateTypeCode', '');
    }
  };

  const handleInvoiceChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const checked = event.target.checked;
    setIsInvoice(checked);
    setValue('isInvoice', checked);

    if (!checked) {
      setValue('invoiceNumber', '');
    }
  };

  useEffect(() => {
    if (initialData) {
      setValue('bankName', initialData.bankName);
      setValue('bankCode', initialData.bankCode);
      setValue('branchName', initialData.branchName);
      setValue('branchCode', initialData.branchCode);
      setValue('accountType', initialData.accountType);
      setValue('accountNumber', initialData.accountNumber);
      setValue('accountHolderName', initialData.accountHolderName);
      setValue('isCorporate', !!initialData.isCorporate);
      setValue('corporateTypeCode', initialData.corporateTypeCode || '');
      setValue('isForeignresident', !!initialData.isForeignresident);
      setValue('investments', initialData.investments || 0);
      setValue('isInvoice', !!initialData.isInvoice);
      setValue('invoiceNumber', initialData.invoiceNumber || '');
    }
  }, [initialData, setValue]);

  const handleBankNameInputChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    setIsSuggestedOpen(true);
    const value = e.target.value;
    setBankName(value);

    if (value) {
      const filteredData = allBanks.filter((bank) => {
        // 検索する文字列が「銀行」を含む場合、「銀行」を除外して比較する
        const searchValue = value.replace(/銀行/g, '');
        return (
          bank.name.includes(searchValue) ||
          bank.hira.includes(searchValue) ||
          bank.kana.includes(searchValue)
        );
      });
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

  const handleBranchCodeChange = async (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const value = e.target.value;
    setBranchCode(value);
    setValue('branchCode', value);

    if (bankCode.length === 4 && value.length === 3) {
      const branch = await fetchBranchByCode(bankCode, value);
      if (branch) {
        setBranchName(branch.name);
        setValue('branchName', branch.name);
      } else {
        setBranchName('');
        setValue('branchName', '');
      }
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
              {errors.branchName && (
                <li>{errors.branchName.message as string}</li>
              )}
              {errors.branchCode && (
                <li>{errors.branchCode.message as string}</li>
              )}
              {errors.accountType && (
                <li>{errors.accountType.message as string}</li>
              )}
              {errors.accountNumber && (
                <li>{errors.accountNumber.message as string}</li>
              )}
              {errors.accountHolderName && (
                <li>{errors.accountHolderName.message as string}</li>
              )}
              {errors.corporateTypeCode && (
                <li>{errors.corporateTypeCode.message as string}</li>
              )}
              {errors.invoiceNumber && (
                <li>{errors.invoiceNumber.message as string}</li>
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

        {!!initialData && (
          <>
            <div className='mb-2'>
              <p className='small mb-1 text-black'>個人 or 法人</p>
              <div className='d-flex'>
                <label className='me-3'>
                  <input
                    className='me-2'
                    type='radio'
                    value='false'
                    {...register('isCorporate')}
                    checked={!isCorporate}
                    onChange={handleCorporateChange}
                    style={{ transform: "scale(1.5)" }}
                  />
                  個人
                </label>
                <label>
                  <input
                    className='me-2'
                    type='radio'
                    value='true'
                    {...register('isCorporate')}
                    checked={isCorporate}
                    onChange={handleCorporateChange}
                    style={{ transform: "scale(1.5)" }}
                  />
                  法人
                </label>
              </div>
            </div>

            {isCorporate && (
              <div className='mb-2'>
                <p className='small mb-1 text-black'>法人形態</p>
                <select
                  {...register('corporateTypeCode', {
                    required: { value: true, message: '法人形態は必須です' },
                  })}
                  className='w-100 p-2'
                >
                  <option value=''>選択してください</option>
                  <option value='kabu'>株式会社</option>
                  <option value='goumei'>合名会社</option>
                  <option value='goushi'>合資会社</option>
                  <option value='yugen'>有限会社</option>
                </select>
              </div>
            )}

            <div className='mb-2'>
              <p className='small mb-1 text-black'>国外在住</p>
              <input
                type='checkbox'
                {...register('isForeignresident')}
                style={{ transform: "scale(1.5)" }}
              />
            </div>

            <div className='mb-2'>
              <p className='small mb-1 text-black'>資本金・出資金</p>
              <input
                type='number'
                className='w-100 p-2'
                placeholder='0'
                {...register('investments', { valueAsNumber: true, min: 0 })}
              />
            </div>

            <div className='mb-2'>
              <p className='small mb-1 text-black'>インボイス番号登録</p>
              <input
                type='checkbox'
                {...register('isInvoice')}
                checked={isInvoice}
                onChange={handleInvoiceChange}
                style={{ transform: "scale(1.5)" }}
              />
            </div>

            {isInvoice && (
              <div className='mb-2'>
                <p className='small mb-1 text-black'>インボイス番号</p>
                <input
                  type='text'
                  className='w-100 p-2'
                  {...register('invoiceNumber', {
                    required: isInvoice ? 'インボイス番号は必須です' : false,
                    pattern: {
                      value: /^T\d{13}$/,
                      message: 'インボイス番号は「T + 13桁の数字」で入力してください',
                    },
                  })}
                />
                {errors.invoiceNumber && (
                  <p className='error-text'>{errors.invoiceNumber.message as string}</p>
                )}
              </div>
            )}
          </>
        )}

        <button type='submit' className='btn btn-primary w-100'>
          口座作成
        </button>
      </div>
    </form>
  );
};

export default BankAccountForm;
