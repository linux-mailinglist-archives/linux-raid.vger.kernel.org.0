Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3257214446E
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jan 2020 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgAUSj3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jan 2020 13:39:29 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17357 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSj3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 21 Jan 2020 13:39:29 -0500
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579631964073394.35633456789435; Tue, 21 Jan 2020 19:39:24 +0100 (CET)
Subject: Re: [PATCH, v2] Add support for Tebibytes
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
References: <20200121093852.21240-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <089ad982-70f7-5224-9d1f-592abbd5d292@trained-monkey.org>
Date:   Tue, 21 Jan 2020 13:39:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121093852.21240-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/21/20 4:38 AM, Kinga Tanska wrote:
> Adding support for Tebibytes enables display size of
> volumes in Tebibytes and Terabytes when they are
> bigger than 2048 GiB (or GB).
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>
> ---
>  mdadm.8.in | 20 ++++++++++----------
>  util.c     | 47 +++++++++++++++++++++++++++++++++--------------
>  2 files changed, 43 insertions(+), 24 deletions(-)

Applied!

Thanks,
Jes



