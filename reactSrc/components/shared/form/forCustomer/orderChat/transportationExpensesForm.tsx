import React, { Dispatch, useEffect, useState } from "react";
import { Order } from "@/types";
import { useForm } from "react-hook-form";
import { Api } from "@/infrastructure";

type Props = {
  order: Order;
  setOrder: Dispatch<React.SetStateAction<Order>>;
};

type TranspotationExpensesFormValues = Pick<Order, "transportationExpenses">;

export const TranspotationExpensesForm: React.FC<Props> = (
  props
): JSX.Element => {
  const { order, setOrder } = props;
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const { register, handleSubmit, setValue } =
    useForm<TranspotationExpensesFormValues>({
      mode: "onChange",
      defaultValues: {
        transportationExpenses: order.transportationExpenses,
      },
    });

  useEffect(() => {
    setValue("transportationExpenses", order.transportationExpenses);
  }, [order]);

  const onSubmit = async (
    values: TranspotationExpensesFormValues
  ): Promise<void> => {
    const requestBody: { [key: string]: TranspotationExpensesFormValues }= {
      order: {
        transportationExpenses: values.transportationExpenses,
      },
    };

    try {
      const response = await Api.patch<Order>(`/orders/${order.id}`, "customer", requestBody);
      setOrder({
        ...order,
        transportationExpenses: response.data.transportationExpenses,
        totalPriceForCustomer: response.data.totalPriceForCustomer,
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
          {!canEdit && (
            <a className="clink" onClick={() => setCanEdit(true)}>
              編集
            </a>
          )}
        </div>
        {canEdit ? (
          <>
            <div className="col-7">
              <input
                className="form-control text-end"
                type="number"
                {...register("transportationExpenses")}
              />
            </div>

            <div className="col-2 py-0">
              <button
                type="submit"
                name="action"
                value="transport_upadte"
                className="btn btn-inline-edit"
              >
                <i className="material-icons color-pr10">done</i>
              </button>
            </div>
          </>
        ) : (
          <div className="col-auto">
            &yen;{order.transportationExpenses?.toLocaleString()}
          </div>
        )}
      </div>
    </form>
  );
};
