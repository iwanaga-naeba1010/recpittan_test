import React, { Dispatch, useEffect, useState } from "react";
import { Order } from "../../../types";
import { useForm } from 'react-hook-form';
import { put } from "../../../utils/requests/base";

type Props = {
  order: Order;
  setOrder: Dispatch<React.SetStateAction<Order>>;
}

export type ExpenseFormValues = Pick<Order, 'expenses'>;

export const ExpenseForm: React.FC<Props> = (props): JSX.Element => {
  const { order, setOrder } = props;
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const {
    register,
    handleSubmit,
    setValue,
  } = useForm<ExpenseFormValues>({
    mode: 'onChange',
    defaultValues: {
      expenses: order.expenses
    }
  });

  useEffect(() => {
    setValue('expenses', order.expenses);
  }, [order]);

  const onSubmit = async (values: ExpenseFormValues): Promise<void> => {
    const requestBody: Record<string, unknown> = {
      order: {
        expenses: values.expenses,
      }
    };

    try {
      const token = document.querySelector('[name=csrf-token]').getAttribute('content');
      const response = await put<Order>( `/api/orders/${order.id}`, requestBody, { 'X-CSRF-TOKEN': token });
      setOrder({ ...order, expenses: response.expenses });
      setCanEdit(false);
    } catch (e) {
      setCanEdit(true);
    }
  };

  return (
    <form className="consult" onSubmit={handleSubmit(onSubmit)}>
      <div className="row justify-content-between border-bottom-dotted py-2">
        <div className="col-3 align-self-center">
          諸経費
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
                  {...register('expenses')}
                />
              </div>

              <div className="col-2 py-0">
                <button type="submit" name="action" value="transport_upadte" className="btn btn-inline-edit">
                  <i className="material-icons color-pr10">done</i>
                </button>
              </div>
            </>
          )
          : ( <div className="col-auto">&yen;{ order.expenses?.toLocaleString() }</div>)
        }
      </div>
    </form>
  );
}

