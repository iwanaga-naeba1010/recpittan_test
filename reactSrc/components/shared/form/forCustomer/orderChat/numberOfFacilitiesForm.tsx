import { Api } from '@/infrastructure';
import { Order } from '@/types';
import React, { Dispatch, useEffect, useState } from 'react';
import { useForm } from 'react-hook-form';

type Props = {
  order: Order;
  setOrder: Dispatch<React.SetStateAction<Order | undefined>>;
};

type NumberOfCacilitiesFormValues = Pick<Order, 'numberOfFacilities'>;

export const NumberOfFacilitiesForm: React.FC<Props> = (props): JSX.Element => {
  const { order, setOrder } = props;
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const { register, handleSubmit, setValue } =
    useForm<NumberOfCacilitiesFormValues>({
      mode: 'onChange',
      defaultValues: {
        numberOfFacilities: order.numberOfFacilities,
      },
    });

  useEffect(() => {
    setValue('numberOfFacilities', order.numberOfFacilities);
  }, [order]);

  const onSubmit = async (
    values: NumberOfCacilitiesFormValues
  ): Promise<void> => {
    const requestBody: { [key: string]: NumberOfCacilitiesFormValues } = {
      order: {
        numberOfFacilities: values.numberOfFacilities,
      },
    };

    try {
      const response = await Api.patch<Order>(
        `/orders/${order.id}`,
        'customer',
        requestBody
      );
      setOrder({
        ...order,
        numberOfFacilities: response.data.numberOfFacilities,
        totalPriceForCustomer: response.data.totalPriceForCustomer,
      });
      setCanEdit(false);
    } catch (e) {
      setCanEdit(true);
    }
  };

  return (
    <>
      {!canEdit ? (
        <div className='row justify-content-between border-bottom-dotted py-2'>
          <div className='col-auto align-self-center'>
            追加施設費 / 追加施設数 {order.numberOfFacilities}施設
            <br />
            {!canEdit && order.isEditable && (
              <a
                id='numberOfFacilitiesEditButton'
                className='clink'
                onClick={() => setCanEdit(true)}
              >
                編集
              </a>
            )}
          </div>
          <div id='numberOfFacilities' className='col-auto'>
            &yen;
            {(
              order.numberOfFacilities * order.additionalFacilityFee
            )?.toLocaleString()}
          </div>
        </div>
      ) : (
        <form className='consult' onSubmit={handleSubmit(onSubmit)}>
          <div className='row justify-content-between border-bottom-dotted py-2'>
            <div className='col-3 align-self-center'>追加施設数</div>
            <div className='col-7'>
              <input
                id='numberOfFacilitiesInput'
                className='form-control text-end'
                type='number'
                {...register('numberOfFacilities')}
              />
            </div>
            <div className='col-2 py-0'>
              <button
                id='numberOfFacilitiesSubmitButton'
                type='submit'
                name='action'
                value='transport_upadte'
                className='btn btn-inline-edit'
              >
                <i className='material-icons color-pr10'>done</i>
              </button>
            </div>
          </div>
        </form>
      )}
    </>
  );
};
