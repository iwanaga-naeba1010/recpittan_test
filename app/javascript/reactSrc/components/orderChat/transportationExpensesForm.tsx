import React, { Dispatch, useEffect, useState } from "react";
import { Order } from "../../../types";
import { useForm } from 'react-hook-form';
import { put } from "../../../utils/requests/base";

type Props = {
  order: Order;
  setOrder: Dispatch<React.SetStateAction<Order>>;
}

type TranspotationExpensesFormValues = Pick<Order, 'transportation_expenses'>;

export const TranspotationExpensesForm: React.FC<Props> = (props): JSX.Element => {
  const { order, setOrder } = props;
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const {
    register,
    handleSubmit,
    setValue,
  } = useForm<TranspotationExpensesFormValues>({
    mode: 'onChange',
    defaultValues: {
      transportation_expenses: order.transportation_expenses
    }
  });

  useEffect(() => {
    setValue('transportation_expenses', order.transportation_expenses);
  }, [order]);

  const onSubmit = async (values: TranspotationExpensesFormValues): Promise<void> => {
    const requestBody: Record<string, unknown> = {
      order: {
        transportation_expenses: values.transportation_expenses,
      }
    };

    try {
      const token = document.querySelector('[name=csrf-token]').getAttribute('content');
      const response = await put<Order>( `/api/orders/${order.id}`, requestBody, { 'X-CSRF-TOKEN': token });
      setOrder({
        ...order,
        transportation_expenses: response.transportation_expenses,
        total_price_for_customer: response.total_price_for_customer
      });
      setCanEdit(false);
    } catch (e) {
      setCanEdit(true);
    }
  };

  return (
    <form className="consult" onSubmit={handleSubmit(onSubmit)}>
      <div className="row justify-content-between border-bottom-dotted py-2">
        <div className="col-3 align-self-center">
          交通費
          <br />
          {!canEdit && <a className="clink" onClick={() => setCanEdit(true)}>編集</a> }
        </div>
        { canEdit
          ? (
            <>
              <div className="col-7">
                <input
                  className="form-control text-end"
                  type="number"
                  {...register('transportation_expenses')}
                />
              </div>

              <div className="col-2 py-0">
                <button type="submit" name="action" value="transport_upadte" className="btn btn-inline-edit">
                  <i className="material-icons color-pr10">done</i>
                </button>
              </div>
            </>
          )
          : ( <div className="col-auto">&yen;{ order.transportation_expenses?.toLocaleString() }</div>)
        }
      </div>
    </form>
  );
}

