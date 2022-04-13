import React, { useEffect, useState } from "react";
import { Order } from "../../../types";
import { useForm, UseFormSetValue } from 'react-hook-form';
import { put } from "../../../utils/requests/base";

type Props = {
  order: Order;
}

export type ExpenseFormValues = Pick<Order, 'expenses'>;

export const ExpenseForm: React.FC<Props> = (props): JSX.Element => {
  const { order } = props;
  const [expenses, setExpenses] = useState<number>();
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
    setExpenses(order.expenses);
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
      console.log(response);
      setExpenses(response.expenses);
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
          : ( <div className="col-auto">&yen;{ expenses?.toLocaleString() }</div>)
        }
      </div>
    </form>
  );
}

