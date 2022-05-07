import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';

if (process.env.RAILS_ENV === 'production') {
  Sentry.init({
    dsn: 'https://a25bef58bb664200906f6622b8b1dedb@o1024150.ingest.sentry.io/6179819',
    integrations: [new BrowserTracing()]
    // environment: process.env.STAGING ? 'staging' : 'production'
  });
}
