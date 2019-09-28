Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C613BC104B
	for <lists+linux-raid@lfdr.de>; Sat, 28 Sep 2019 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfI1JEx (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 28 Sep 2019 05:04:53 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37045 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfI1JEx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 28 Sep 2019 05:04:53 -0400
Received: by mail-wm1-f44.google.com with SMTP id f22so7762933wmc.2
        for <linux-raid@vger.kernel.org>; Sat, 28 Sep 2019 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jobmin7+2IEXEhPGPbryJhyGZEbJjrSf1zC/onYLuj8=;
        b=ZNyTVH/waMOnRW4KB8yGpKya9s32Vu1IQGpEyb6VWgNpfFGcoENoBVERjm6sJFEYOm
         nQeNIrXRgXuv39VDCcOqlIp3tIfj5S6Jd9xIUxX14w0yN9KOuf+MiLxtonB3uuBZ6gz1
         3AmZAtsabNbbr8znqRtWqWPRzpRXY649d1j1DOyVyGeQ7r6ja6A5XY+DB9Cz+uNq9DQY
         KTv0cw/T1GoutmT3IllQVfx9fiOVuWunLX9aZYh8Gh8Qsv8euSBaYzD+KRj5BRwr1JOX
         JQiEGyxY1N/Mc0KWROC6tzPZDj939J+yOt71bbgVfirhNYUX5J5znI+3EFwDu2DPf5Q+
         Kxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jobmin7+2IEXEhPGPbryJhyGZEbJjrSf1zC/onYLuj8=;
        b=bqBM6yPc8ceKCVpDxnVpUDbdCS+UuB3Gnaw9ElwHSL3vZntO2dYg+HMWeNqeOWrucw
         NF1D6v7FMbXIuguzJ1csVJCCDxo68iJKQ3hl/Ufqz7PwMDGvA+PAx++9Z6sBIx33qufN
         HSnHBOVb7VSrSSITbjZHDaVQXzKOaUYGrj7QY0QBVqM+irwRTXHHPbAPj63nvxWQy5W0
         wo+HlglpH87mH3KbjedAhp5IK4xQetaAZMHNz0L1ebaIjSWfsILKVUFJeAF7Sjau+mwm
         RQkhUTBCuBUtA5Jkg9ZCF2GPgwPi3MJRmFbJ+CkNtE2gNoMXzEeY9N2FCiOIc+TfQzM3
         RcHw==
X-Gm-Message-State: APjAAAVKtfCyO2uNbRTL/v6tiYCT6PElk0ck260+wKSG9G+X62Bs09s2
        a6B42R5fbdf2gGrgPKfuCX6Bd8ThcxLZsEvzEWYUCw==
X-Google-Smtp-Source: APXvYqzdfCvzWgdZULnWq/lYNZ9rRvWux4I4WTuZOVIxJv3tw/Ru/C8N6cyMNrkwPDeXY6rXBi+3J3PJlvR5oMwgmaY=
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr10344817wmc.140.1569661491682;
 Sat, 28 Sep 2019 02:04:51 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sat, 28 Sep 2019 02:04:40 -0700
Message-ID: <CAGRSmLt2pZ3mhizOn-zNdMGODCvn4g90fbKERraP8ZzN2iS37Q@mail.gmail.com>
Subject: prevent scan of floppy and cd drives?
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

How do you prevent mdadm --scan from hitting floppy or cd drives?

TIA!!
