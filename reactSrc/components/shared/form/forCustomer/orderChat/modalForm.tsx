import { Error } from '@/components/shared';
import { Api } from '@/infrastructure';
import { City, Order, Prefecture, PreferredDate, Recreation } from '@/types';
import {
  findAddressByZip,
  findAllPrefectures,
  findCityByPrefectureCode,
  isEmpty,
} from '@/utils';
import axios, { AxiosError } from 'axios';
import React, { useEffect, useState } from 'react';
import { useForm } from 'react-hook-form';

type Props = {
  order: Order;
  recreation: Recreation;
};

type StartAndEndAt = {
  year: string;
  month: string;
  day: string;
  startHour: string;
  startMinute: string;
  endHour: string;
  endMinute: string;
};

export type ModalForlValues = Pick<
  Order,
  | 'zip'
  | 'prefecture'
  | 'city'
  | 'street'
  | 'building'
  | 'numberOfPeople'
  | 'numberOfFacilities'
  | 'couponCode'
  | 'startAt'
  | 'endAt'
> &
  StartAndEndAt;

export const ModalForm: React.FC<Props> = (props) => {
  const { order, recreation } = props;
  const [preferredDate, setPreferredDate] = useState<PreferredDate>();
  const [prefectures, setPrefectures] = useState<Array<Prefecture>>([]);
  const [cities, setCities] = useState<Array<City>>([]);
  const [errors, setErrors] = useState<Array<string>>([]);
  const [isCouponApplied, setIsCouponApplied] = useState<boolean>();

  const {
    register,
    handleSubmit,
    setValue,
    getValues,
    trigger,
    reset,
    formState: { isValid },
  } = useForm<ModalForlValues>({
    mode: 'onChange',
    defaultValues: {
      year: '',
      month: '',
      day: '',
      startHour: '',
      startMinute: '',
      endHour: '',
      endMinute: '',
      numberOfPeople: order.numberOfPeople,
      numberOfFacilities: order.numberOfFacilities,
      zip: order.zip,
      prefecture: order.prefecture,
      city: order.city,
      street: order.street,
      building: order.building,
      couponCode: order.couponCode,
    },
  });

  const filterCurrentPrefecture = (prefName: string): Prefecture =>
    prefectures.filter((prefecture) => prefecture.prefName === prefName)[0];

  useEffect(() => {
    (async () => {
      try {
        setErrors([]);
        const response = await Api.get<PreferredDate>(
          '/orders/preferred_date',
          'customer'
        );
        setPreferredDate(response.data);

        const { data } = await findAllPrefectures();
        setPrefectures(data.result);
      } catch (e) {
        if (axios.isAxiosError(e)) {
          const axiosError = e as AxiosError<Array<string>>;
          if (axiosError.response) {
            setErrors(axiosError.response.data);
            console.log(axiosError.response.data);
          }
        }
      }
    })();
  }, []);

  const handleZipChange = async (): Promise<void> => {
    try {
      const zip = getValues('zip'); // 事前にzipの値を取得

      const { data } = await findAddressByZip(zip);
      const { address1, address2, address3 } = data.results[0];

      const pref = filterCurrentPrefecture(address1);
      await handleCityChange(pref.prefCode);

      // 現在のフォームの値を取得し、新しい住所情報を追加
      const currentValues = getValues();
      reset({
        ...currentValues, // 現在の値をすべて保持
        zip, // zip も明示的にセット
        prefecture: address1,
        city: address2,
        street: address3,
      });

      await trigger(); // すべてのバリデーションを再評価
    } catch (error) {
      console.error('郵便番号検索エラー:', error);
    }
  };

  const handleCityChange = async (prefCode: number): Promise<void> => {
    try {
      const response = await findCityByPrefectureCode(prefCode);
      setCities(response.data.result);
    } catch (e) {
      if (axios.isAxiosError(e)) {
        console.warn('error is', e);
      }
    }
  };

  const handleApplyCouponCode = (input: string) => {
    if (input === 'えぶりぷらす') {
      setIsCouponApplied(true);
      setValue('couponCode', input);
      return;
    }
    setIsCouponApplied(false);
  };

  const onSubmit = async (values: ModalForlValues): Promise<void> => {
    setErrors([]);
    const startAt: Date = new Date(
      `${getValues('year')}-${getValues('month')}-${getValues(
        'day'
      )} ${getValues('startHour')}:${getValues('startMinute')}`
    );

    const endAt: Date = new Date(
      `${getValues('year')}-${getValues('month')}-${getValues(
        'day'
      )} ${getValues('endHour')}:${getValues('endMinute')}`
    );

    const requestBody: {
      [key: string]: Omit<
        ModalForlValues,
        | 'year'
        | 'month'
        | 'day'
        | 'startHour'
        | 'startMinute'
        | 'endHour'
        | 'endMinute'
      >;
    } = {
      order: {
        zip: values.zip,
        prefecture: values.prefecture,
        city: values.city,
        street: values.street,
        building: values.building,
        numberOfPeople: values.numberOfPeople,
        numberOfFacilities: values.numberOfFacilities,
        couponCode: isCouponApplied ? values.couponCode : '',
        startAt,
        endAt,
      },
    };

    try {
      await Api.patch<Order>(`/orders/${order.id}`, 'customer', requestBody);
      window.location.href = `/customers/orders/${order.id}/complete`;
    } catch (e) {
      if (axios.isAxiosError(e)) {
        const axiosError = e as AxiosError<Array<string>>;
        if (axiosError.response) {
          setErrors(axiosError.response.data);
          console.log(axiosError.response.data);
        }
      }
      console.log(e);
    }
  };

  return (
    <div
      className='modal'
      id='orderModal'
      tabIndex={-1}
      aria-labelledby='orderModalLabel'
      aria-hidden='true'
    >
      <div className='modal-dialog modal-lg'>
        <div className='modal-content'>
          <div className='modal-header'>
            <h5 className='modal-title' id='orderModalLabel'>
              正式依頼フォーム
            </h5>
          </div>
          <div className='modal-body p-2'>
            {!isEmpty(errors) && <Error errors={errors} />}
            <form className='order h-adr' onSubmit={handleSubmit(onSubmit)}>
              <div className='container-fluid'>
                <div className='row pb-3'>
                  <div className='col-auto'>
                    <h3 className='title-b p-0'>
                      開催したい希望日と時間を選択してください
                      <span className='label required'>必須</span>
                    </h3>
                    <span className='text-muted'>
                      パートナー都合で希望日時の開催が難しい場合がございます。事前にチャットでの開催日時の相談をお願いします。
                    </span>
                  </div>
                </div>
                <div className='date-form'>
                  <div className='row'>
                    <div className='col-12'>希望日</div>
                    <div className='form-group col-3'>
                      <select
                        {...register('year', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.years.map((year) => (
                          <option key={year} value={year}>
                            {year}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>年</div>
                    <div className='form-group col-3'>
                      <select
                        {...register('month', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.months.map((month) => (
                          <option key={month} value={month}>
                            {month}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>月</div>
                    <div className='form-group col-3'>
                      <select
                        {...register('day', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.days.map((day) => (
                          <option key={day} value={day}>
                            {day}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>日</div>
                  </div>
                  <div className='row'>
                    <div className='col-12'>希望時間</div>
                    <div className='form-group col-2 pe-0'>
                      <select
                        {...register('startHour', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.hours.map((hour) => (
                          <option key={hour} value={hour}>
                            {hour}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>:</div>
                    <div className='form-group col-2 pe-0'>
                      <select
                        {...register('startMinute', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.minutes.map((minute) => (
                          <option key={minute} value={minute}>
                            {minute}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>~</div>
                    <div className='form-group col-2 pe-0'>
                      <select
                        {...register('endHour', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.hours.map((hour) => (
                          <option key={hour} value={hour}>
                            {hour}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div className='col-auto p-0 flex-v-c'>:</div>
                    <div className='form-group col-2 pe-0'>
                      <select
                        {...register('endMinute', { required: true })}
                        className='form-control'
                      >
                        <option value=''></option>
                        {preferredDate?.minutes.map((minute) => (
                          <option key={minute} value={minute}>
                            {minute}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>
                </div>
                <div className='row pt-3'>
                  <label className='col-12 title-b pb-3' htmlFor='participant'>
                    希望人数を入力してください
                    <span className='label required'>必須</span>
                  </label>
                  <div className='form-group col-3'>
                    <input
                      {...register('numberOfPeople', { required: true })}
                      className='form-control text-right'
                    />
                  </div>
                  <div className='col-auto p-0 flex-v-c'>人</div>
                </div>

                {recreation.kind.key === 'online' && (
                  <div className='row pt-3'>
                    <label
                      className='col-12 title-b pb-3'
                      htmlFor='participant'
                    >
                      追加で参加する施設がある場合施設数をご記入ください
                    </label>
                    <div className='form-group col-3'>
                      <input
                        {...register('numberOfFacilities')}
                        className='form-control text-right'
                      />
                    </div>
                    <div className='col-auto p-0 flex-v-c'>施設</div>
                  </div>
                )}

                <div className='row pt-3'>
                  <span className='p-country-name' style={{ display: 'none' }}>
                    Japan
                  </span>
                  <label className='col-12 title-b pb-3' htmlFor='participant'>
                    <span>今回の開催する施設の住所を入力してください</span>
                    <span className='label required'>必須</span>
                  </label>
                  <div className='form-group col-6'>
                    <label htmlFor='postalCode'>郵便番号</label>
                    <div className='input-group mb-3'>
                      <input
                        {...register('zip', { required: true })}
                        className='form-control p-postal-control'
                        placeholder='郵便番号を入力'
                        autoComplete='off'
                      />
                      <button
                        id='searchAddressWithZipForOrder'
                        onClick={() => handleZipChange()}
                        className='btn btn-outline-secondary p-postal-code-find'
                        type='button'
                      >
                        検索
                      </button>
                    </div>
                  </div>
                  <div className='form-group col-6'>
                    <label htmlFor='postalCode'>都道府県</label>
                    <select
                      {...register('prefecture', { required: true })}
                      className='form-control p-region'
                      onChange={(e) =>
                        handleCityChange(
                          filterCurrentPrefecture(e.target.value).prefCode
                        )
                      }
                      autoComplete='off'
                    >
                      {prefectures.map((prefecture) => (
                        <option
                          key={prefecture.prefName}
                          value={prefecture.prefName}
                        >
                          {prefecture.prefName}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className='form-group col-6'>
                    <label htmlFor='postalCode'>市区町村</label>
                    <select
                      {...register('city', { required: true })}
                      className='form-control p-region'
                      autoComplete='off'
                    >
                      {cities.map((city) => (
                        <option key={city.cityName} value={city.cityName}>
                          {city.cityName}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className='form-group col-6'>
                    <label htmlFor='postalCode'>町名/番地</label>
                    <input
                      {...register('street', { required: true })}
                      className='form-control p-postal-control'
                      autoComplete='off'
                    />
                  </div>
                  <div className='form-group col-12'>
                    <label htmlFor='postalCode'>建物名</label>
                    <input
                      {...register('building')}
                      className='form-control p-postal-control'
                      autoComplete='off'
                    />
                  </div>
                </div>

                <div className='input-group w-50'>
                  <label className='col-12 title-b py-3' htmlFor='participant'>
                    <span>クーポンコードをお持ちの方</span>
                  </label>
                  <input
                    {...register('couponCode')}
                    className='form-control text-right'
                  />
                  <button
                    onClick={() =>
                      handleApplyCouponCode(getValues('couponCode'))
                    }
                    className='btn btn-csecondar ms-2 px-3 rounded border-0 text-white font-weight-bold'
                    type='button'
                  >
                    適用
                  </button>
                </div>

                <div className='card mt-3'>
                  <div id='OrderForm'></div>
                  <div className='card-body'>
                    <h5 className='card-title title-b'>レク 費用</h5>
                    <div className='row justify-content-between border-bottom-dotted pb-2'>
                      <div className='col-auto'>開催費</div>
                      <div className='col-auto'>
                        &yen;
                        {order?.price?.toLocaleString()}
                      </div>
                    </div>
                    <div className='row justify-content-between border-bottom-dotted py-2'>
                      <div className='col-auto'>
                        <span id='participantNum'>材料費/1人</span>
                        <br />
                        <span className='text-muted font-12 color-ba08'>
                          ※材料費は人数分の費用が発生します
                        </span>
                      </div>
                      <div id='materialPrice' className='col-auto'>
                        &yen;
                        {order?.materialPrice?.toLocaleString()}
                      </div>
                    </div>
                    {recreation.kind.key === 'visit' && (
                      <div className='row justify-content-between border-bottom-dotted pb-2'>
                        <div className='col-auto'>交通費</div>
                        <div
                          id='transportationExpensesForOrderForm'
                          className='col-auto'
                        >
                          &yen;
                          {order?.transportationExpenses?.toLocaleString()}
                        </div>
                      </div>
                    )}
                    <div className='row justify-content-between border-bottom-dotted pb-2'>
                      <div className='col-auto'>諸経費</div>
                      <div id='expensesForOrderForm' className='col-auto'>
                        &yen;
                        {order?.expenses?.toLocaleString()}
                      </div>
                    </div>
                    {recreation.kind.key === 'online' && (
                      <div className='row justify-content-between border-bottom-dotted pb-2'>
                        <div className='col-auto'>
                          追加施設費 /
                          <span id='numberOfFacilitiesForOrderFormLabel'>
                            {order.numberOfFacilities} 施設
                          </span>
                        </div>
                        <div
                          id='numberOfFacilitiesForOrderForm'
                          className='col-auto'
                        >
                          {order?.totalFacilityPriceForCustomer?.toLocaleString()}
                        </div>
                      </div>
                    )}
                    <div className='row justify-content-between border-top py-3'>
                      <div className='col-auto'>合計(税別)</div>
                      <div id='totalPriceForOrderForm' className='col-auto'>
                        &yen;
                        {order?.totalPriceForCustomer?.toLocaleString()}
                      </div>
                    </div>
                    {isCouponApplied && (
                      <div className='alert alert-warning' role='alert'>
                        <div className='font-weight-boild'>
                          クーポン適用中のため合計金額は「&yen; 0」となります
                        </div>
                        <div>
                          合計金額が表示されていても請求は&yen;
                          0となります。ご安心ください。
                        </div>
                      </div>
                    )}
                    {isCouponApplied === false && (
                      <div className='alert alert-danger' role='alert'>
                        このクーポンは存在していません
                      </div>
                    )}
                  </div>
                </div>

                <div className='card mt-4'>
                  <div className='card-body'>
                    <h5 className='card-title title-b'>注意事項</h5>
                    <p>
                      ・一度承認されたレクのキャンセルはできません。規約に準じた日程の変更は可能です。詳しくは利用規約をご確認ください。
                    </p>
                    <p>
                      ・材料費、オンラインレクの追加施設数、諸経費は開催までの間にパートナーとチャットで相談をして変更することが可能です。その場合、金額の変動がございます。
                    </p>
                    <p>
                      ・材料費が必要なレクは参加人数が増える場合や減る場合はパートナーとチャット相談をしてください。人数が減る場合、レクによっては準備した分の材料費分の請
                      求が発生する場合がございます。詳しくはパートナーにご確認をお願い致します。
                    </p>
                  </div>
                </div>
                <div className='row justify-content-center py-3'>
                  <div className='col-7 mb-3 text-center'>
                    <span className='text-muted'>
                      ※パートナーが承認をする事で正式に開催が決まります
                    </span>
                  </div>
                  <div className='col-7 text-center'>
                    <button
                      type='submit'
                      className={
                        isValid
                          ? 'btn btn-cprimary rounded-pill font-14 py-3 px-4 font-weight-bold text-white'
                          : `btn-cpr disabled`
                      }
                      disabled={!isValid}
                    >
                      パートナーにレク開催を正式依頼する
                    </button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};
