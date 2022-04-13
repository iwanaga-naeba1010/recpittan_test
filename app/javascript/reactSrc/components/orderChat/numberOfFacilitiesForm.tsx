import React, { useEffect, useState } from "react";
import { Order } from "../../../types";
import { useForm } from 'react-hook-form';
import { put } from "../../../utils/requests/base";

type Props = {
  order: Order;
}

type NumberOfCacilitiesFormValues = Pick<Order, 'number_of_facilities'>;

export const NumberOfFacilitiesForm: React.FC<Props> = (props): JSX.Element => {
  const {order} = props;
  const [numberOfFacilities, setNumberOfFacilities] = useState<number>();
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const {
    register,
    handleSubmit,
    setValue,
  } = useForm<NumberOfCacilitiesFormValues>({
    mode: 'onChange',
    defaultValues: {
      number_of_facilities: order.number_of_facilities
    }
  });

  useEffect(() => {
    setNumberOfFacilities(order.number_of_facilities);
    setValue('number_of_facilities', order.number_of_facilities);
  }, [order]);

  const onSubmit = async (values: NumberOfCacilitiesFormValues): Promise<void> => {
    const requestBody: Record<string, unknown> = {
      order: {
        number_of_facilities: values.number_of_facilities,
      }
    };

    try {
      const token = document.querySelector('[name=csrf-token]').getAttribute('content');
      const response = await put<Order>(`/api/orders/${order.id}`, requestBody, {'X-CSRF-TOKEN': token});
      console.log(response);
      setNumberOfFacilities(response.number_of_facilities);
      setCanEdit(false);
    } catch (e) {
      setCanEdit(true);
    }
  };

  return (
    <>
      {!canEdit
        ? (
          <div className="row justify-content-between border-bottom-dotted py-2">
            <div className="col-auto align-self-center">
              追加施設費 / 追加施設数 {numberOfFacilities}施設
              <br />
              {!canEdit && <a className="clink" onClick={() => setCanEdit(true)}>編集</a>}
            </div>
            <div className="col-auto">&yen;
              {(numberOfFacilities * order.additional_facility_fee)?.toLocaleString()}
            </div>
          </div>
        )
        : (
          <form className="consult" onSubmit={handleSubmit(onSubmit)}>
            <div className="row justify-content-between border-bottom-dotted py-2">
              <div className="col-3 align-self-center">
                追加施設数
              </div>
              <div className="col-7">
                <input
                  id="number_of_facilities"
                  className="form-control text-end"
                  type="number"
                  {...register('number_of_facilities')}
                />
              </div>
              <div className="col-2 py-0">
                <button type="submit" name="action" value="transport_upadte" className="btn btn-inline-edit">
                  <i className="material-icons color-pr10">done</i>
                </button>
              </div>
            </div>
          </form>
        )
      }
    </>
  )
}

